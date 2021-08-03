import java.util.Collections;

class ScoreEntry {
    public final String name;
    public final int score;
    public final long timestamp;

    public ScoreEntry(String name, int score) {
        this(name, score, System.currentTimeMillis());
    }

    public ScoreEntry(String name, int score, long timestamp) {
        this.name = name;
        this.score = score;
        this.timestamp = timestamp;
    }

    @Override
    public String toString() {
        return "{name=" + name + ", score=" + score + ", timestamp=" + timestamp + "}";
    }
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

    boolean sumbitScore(ScoreEntry score) {
        allScores.add(score);

        int userIndex = -1;
        for (int i=0; i<highScores.size(); ++i) {
            if (highScores.get(i).name != score.name) continue;

            userIndex = i;
            break;
        }

        if (userIndex != -1) {
            if (score.score > highScores.get(userIndex).score) 
                highScores.remove(userIndex);
            else return false;
        }
        
        boolean added = false;
        for (int i=0; i<highScores.size()-1; ++i) {
            ScoreEntry entry = highScores.get(i);
            ScoreEntry entry2 = highScores.get(i+1);
            
            if (inBoundsIncl(score.score, entry.score, entry2.score)) {
                highScores.add(i + 1, score);
                added = true;
                break;
            }
        }

        if (added && highScores.size() < 10) highScores.add(score);

        while (highScores.size() > 10) highScores.remove(highScores.size() - 1);
        return added;
    }

    void save() {
        save("scoreboard.json");
    }

    void save(String filename) {
        saveJSONObject(scoreBoardToJson(this), "data/" + filename) ;
    }
}

ScoreBoard scoreboard = importScoreBoard();
