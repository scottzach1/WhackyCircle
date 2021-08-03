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
        Long.parseLong(json.getString("timestamp"))
    );
}

public JSONObject scoreEntryToJson(ScoreEntry s) {
    JSONObject json = new JSONObject();
    json.setString("name", s.name);
    json.setInt("score", s.score);
    json.setString("timestamp", String.valueOf(s.timestamp)); // no setDouble() :<
    return json;
}

JSONObject scoreBoardToJson(ScoreBoard s) {
    JSONArray jsonHighScores = new JSONArray();
    for (int i=0; i<s.highScores.size(); ++i) 
        jsonHighScores.setJSONObject(i, scoreEntryToJson(s.highScores.get(i)));

    JSONArray jsonAllScores = new JSONArray();
    for (int i=0; i<s.allScores.size(); ++i) 
        jsonAllScores.setJSONObject(i, scoreEntryToJson(s.allScores.get(i)));

    JSONObject json = new JSONObject();
    json.setJSONArray("highScores", jsonHighScores);
    json.setJSONArray("allScores", jsonAllScores);
    return json;
}


ScoreBoard scoreBoardFromJson(JSONObject json) {
    if (json == null) {
        println("ScoreBoard was of invalid JSON syntax, received NULL.");
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
    return importScoreBoard("scoreboard.json");
}

ScoreBoard importScoreBoard(String filename) {
    return scoreBoardFromJson(loadJSONObject(filename));
}
