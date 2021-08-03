import java.util.UUID;

// ======================================================================
// ========================= GAME METRICS ===============================
// ======================================================================

class MetricRow {
    public final String name;
    public final int phase;
    public final float timeToClick;
    public final UUID gameId;
    public final long timestamp;

    public MetricRow(String name,
                     int phase,
                     float timeToClick,
                     UUID gameId) {
        
        this(name, phase, timeToClick, gameId, System.currentTimeMillis());
    }

    public MetricRow(String name,
                     int phase,
                     float timeToClick,
                     UUID gameId,
                     long timestamp) {
        
        this.name = name;
        this.phase = phase;
        this.timeToClick = timeToClick;
        this.gameId = gameId;
        this.timestamp = timestamp;
    }

    @Override
    public String toString() {
        return "{name=" + name + ", phase=" + phase + ", timeToClick=" + timeToClick +
            ", gameId=" + gameId.toString() + ", timestamp=" + timestamp + "}";
    }

}

ArrayList<MetricRow> loadMetrics() {
    return loadMetrics("metrics.csv");
}

ArrayList<MetricRow> loadMetrics(String filename) {
    Table table = loadTable("data/" + filename, "header");

    ArrayList<MetricRow> metrics = new ArrayList();

    for (TableRow row : table.rows()) {

        metrics.add(
            new MetricRow(
                row.getString("name"),
                row.getInt("phase"),
                row.getFloat("timeToClick"),
                UUID.fromString(row.getString("gameId")),
                Long.valueOf(row.getString("timestamp"))
            )
        );
    }
    return metrics;
}

void saveMetrics(ArrayList<MetricRow> metrics) {
    saveMetrics(metrics, "metrics.csv");
}

void saveMetrics(ArrayList<MetricRow> metrics, String filename) {
    Table table = new Table();

    table.addColumn("name", Table.STRING);
    table.addColumn("phase", Table.INT);
    table.addColumn("timeToClick", Table.FLOAT);
    table.addColumn("gameId", Table.STRING);
    table.addColumn("timestamp", Table.STRING);

    for (MetricRow m : metrics) {
        TableRow row = table.addRow();

        row.setString("name", m.name);
        row.setInt("phase", m.phase);
        row.setFloat("timeToClick", m.timeToClick);
        row.setString("gameId", m.gameId.toString());
        row.setString("timestamp", String.valueOf(System.currentTimeMillis()));
    }

    saveTable(table, "data/" + filename);
}

// ======================================================================
// ========================== GAME PATHS ================================
// ======================================================================

UUID saveGamePaths(ArrayList<Phase> phases) {
    return saveGamePaths(phases, UUID.randomUUID());
}

UUID saveGamePaths(ArrayList<Phase> phases, UUID gameId) {
    Table table = new Table();

    table.addColumn("gameId", Table.STRING);
    table.addColumn("path", Table.INT);
    table.addColumn("result", Table.INT);
    table.addColumn("timestamp", Table.STRING);
    table.addColumn("mouseX", Table.INT);
    table.addColumn("mouseY", Table.INT);

    for (Phase phase : phases) {
        for (Test test : phase.getTests()) {
            int resultId = -1;
            for (Test.Result result : test.getResults()) {
                ++resultId;
                int pathId = -1;
                for (Pair<Long, Point> pathEntry : result.getPath()) {
                    ++pathId;
                    long t = pathEntry.left;
                    Point p = pathEntry.right;

                    TableRow row = table.addRow();

                    row.setString("gameId", gameId.toString());
                    row.setInt("path", pathId);
                    row.setInt("result", resultId);
                    row.setString("timestamp", String.valueOf(t));
                    row.setInt("mouseX", p.x);
                    row.setInt("mouseY", p.y);
                } // path
            } // result
        } // test
    } // phase (that was a few!)

    saveTable(table, "export/game-" + gameId.toString() + ".csv");

    return gameId;
}
