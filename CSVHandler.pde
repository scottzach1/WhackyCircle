import java.util.UUID;

// ======================================================================
// ========================= GAME METRICS ===============================
// ======================================================================

class MetricRow {
    public final String name;
    public final int phase;
    public final HashMap<String, Long> metrics = new HashMap();
    public final UUID gameId;
    public final long timestamp;

    public MetricRow(String name, int phase, UUID gameId) {
        this(name, phase, gameId, System.currentTimeMillis());
    }

    public MetricRow(String name, int phase, UUID gameId, long timestamp) {
        this.name = name;
        this.phase = phase;
        this.gameId = gameId;
        this.timestamp = timestamp;
    }

    @Override
    public String toString() {
        return "{name=" + name + ", phase=" + phase + ", map=LOTS, gameId=" + gameId.toString() + ", timestamp=" + timestamp + "}";
    }

}

void saveMetricsToFile(ArrayList<MetricRow> metrics, UUID gameId, String name) {
    Table table = new Table();

    table.addColumn("name", Table.STRING);
    table.addColumn("phase", Table.INT);
    table.addColumn("gameId", Table.STRING);
    table.addColumn("timestamp", Table.STRING);

    // Dynamically add visitor attributes
    HashMap<String, Integer> keys = new HashMap();

    for (MetricRow m : metrics) for (String s : m.metrics.keySet()) keys.put(s, 0);
    for (String s : keys.keySet()) table.addColumn(s, Table.STRING);

    for (MetricRow m : metrics) {
        TableRow row = table.addRow();

        row.setString("name", m.name);
        row.setInt("phase", m.phase);
        row.setString("gameId", m.gameId.toString());
        row.setString("timestamp", String.valueOf(System.currentTimeMillis()));

        for (HashMap.Entry<String,Long> e : m.metrics.entrySet())
            row.setString(e.getKey(), String.valueOf(e.getValue()));
    }

    saveTable(table, "export/" + name + "-metrics-" + gameId.toString() + ".csv");
}

// ======================================================================
// ========================== GAME PATHS ================================
// ======================================================================

UUID saveGamePaths(ArrayList<Phase> phases, UUID gameId, String name) {
    Table table = new Table();

    table.addColumn("gameId", Table.STRING);
    table.addColumn("name", Table.STRING);
    table.addColumn("phase", Table.INT);
    table.addColumn("result", Table.INT);
    table.addColumn("path", Table.INT);
    table.addColumn("timestamp", Table.STRING);
    table.addColumn("mouseX", Table.INT);
    table.addColumn("mouseY", Table.INT);

    int phaseId = -1;
    for (Phase phase : phases) {
        ++phaseId;
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
                    row.setString("name", name);
                    row.setInt("phase", phaseId);
                    row.setInt("result", resultId);
                    row.setInt("path", pathId);
                    row.setString("timestamp", String.valueOf(t));
                    row.setInt("mouseX", p.x);
                    row.setInt("mouseY", p.y);
                } // path
            } // result
        } // test
    } // phase (that was a few!)

    saveTable(table, "export/" + name + "-path-" + gameId.toString() + ".csv");
    return gameId;
}
