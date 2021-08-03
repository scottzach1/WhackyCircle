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

    @Override
    public int compareTo(ScoreEntry other) {
        return this.score - other.score;
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
            break ;
        }

        if (userIndex != -1) {
            if (score.score > highScores.get(userIndex).score) 
                highScores.remove(userIndex);
            else return;
        }

        for (int i=0; i<highScores.size()-1, ++i) {
            ScoreEntry entry = highScores.get(i);
            ScoreEntry entry2 = highScores.get(i+1);
            
            if (inBoundsIncl(score.score, entry.score, entry2.score)) {
                highScores.add(i + 1, score);
                return;
            }
        }

        if (highScores.size() < 10) highScores.add(score);
        while (highScores.size() > 10) highScores.remove(highScores.size() - 1);
    }

    void save() {
        export("scoreboard.json");
    }

    void save(String filename) {
        saveJSONObject(this.toJson(), "data/" + filename) ;
    }
}

ScoreBoard scoreboard;
