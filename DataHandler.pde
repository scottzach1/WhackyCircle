class ScoreEntry {
    public final String name;
    public final int score;
    public final long timestamp;

    public ScoreEntry(String name, int score, long timestamp) {
        this.name = name;
        this.score = score;
        this.timestamp = timestamp;
    }

    public JSONObject toJson() {
        JSONObject json = new JSONObject();
        json.setString("name", this.name);
        json.setInt("score", this.score);
        json.setString("timestamp", String.valueOf(this.timestamp)); // no setDouble() :<
        return json;
    }

    @Override
    public String toString() {
        return "{name=" + name + ", score=" + score + ", timestamp=" + timestamp + "}";
    }
}

/**
 * EW... I hate this, I hate that Processing can't have class methods (because everything is an
 * inner class of the global PApplet class behind the scenes... YUCK!!!)
 */
ScoreEntry scoreEntryFromJson(JSONObject json) {
    if (json == null) {
        println("ScoreEntry was of invalid JSON syntax, received NULL.");
        return null;
    }

    return new ScoreEntry(
        json.getString("name"),
        json.getInt("score"),
        // Long.parseLong(json.getString("timestamp"))
        System.currentTimeMillis()
    );
}

ScoreBoard scoreBoardFromJson(JSONObject json) {
    if (json == null) {
        println("ScoreEntry was of invalid JSON syntax, received NULL.");
        return null;
    }

    JSONArray jsonHighScores = json.getJSONArray("highScores");
    JSONArray jsonAllScores = json.getJSONArray("allScores");
    
    ArrayList<ScoreEntry> highScores = new ArrayList(jsonHighScores.size());
    for (int i=0; i<jsonHighScores.size(); ++i) highScores.add(scoreEntryFromJson(jsonHighScores.getJSONObject(i)));

    ArrayList<ScoreEntry> allScores = new ArrayList(jsonAllScores.size());
    for (int i=0; i<jsonAllScores.size(); ++i) allScores.add(scoreEntryFromJson(jsonAllScores.getJSONObject(i)));

    return new ScoreBoard(highScores, allScores);
}

ScoreBoard importScoreBoard() {
    return scoreBoardFromJson(loadJSONObject("data/scoreboard.json"));
}

class ScoreBoard {
    ArrayList<ScoreEntry> highScores = new ArrayList();
    ArrayList<ScoreEntry> allScores = new ArrayList();

    ScoreBoard() {
        this.highScores = new ArrayList();
        this.allScores = new ArrayList();
    }

    ScoreBoard(ArrayList<ScoreEntry> highScores, ArrayList<ScoreEntry> allScores) {
        this.highScores = highScores;
        this.allScores = allScores;
    }

    JSONObject toJson() {
        JSONArray jsonHighScores = new JSONArray();
        for (int i=0; i<highScores.size(); ++i) jsonHighScores.setJSONObject(i, highScores.get(i).toJson());

        JSONArray jsonAllScores = new JSONArray();
        for (int i=0; i<allScores.size(); ++i) jsonAllScores.setJSONObject(i, allScores.get(i).toJson());

        JSONObject json = new JSONObject();
        json.setJSONArray("highScores", jsonHighScores);
        json.setJSONArray("allScores", jsonAllScores);

        return json;
    }

    void export() {
        export("scoreboard.json");
    }

    void export(String path) {
        saveJSONObject(this.toJson(), "data/" +path);
    }
}

void loadScoresFromFile() {
    ScoreBoard scores = importScoreBoard();

    println(scores.highScores.size());
    println(scores.allScores.size());

    println(scores.highScores);
    println(scores.allScores);
}
