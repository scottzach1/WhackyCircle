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
            if (highScores.get(i).name.equals(score.name)) {
                userIndex = i;
                break;
            }
        }

        if (userIndex > -1) {
            if (score.score > highScores.get(userIndex).score) 
                highScores.remove(userIndex);
            else return false;
        }

        int scoreIndex = -1;
        for (int i=0; i<highScores.size(); ++i) {
            if (score.score > highScores.get(i).score) {
                scoreIndex = i;
                break;
            }
        }

        boolean added = true;
        if (scoreIndex != -1) {
            highScores.add(scoreIndex, score);
        } else if (highScores.size() < 10) {
            highScores.add(score);
        } else added = false;

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
