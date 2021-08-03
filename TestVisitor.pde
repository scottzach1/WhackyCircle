abstract class TestVisitor {
    abstract Long acceptTest(Test test);
    abstract String metricKey();

    void acceptPhase(Phase p) {
        for (Test t : p.getTests()) t.accept(this);
    }

    <T> ArrayList<T> collectResults(ArrayList<Test.Result> results, Func<T> func) {
        ArrayList<T> vResults = new ArrayList(results.size());

        for (Test.Result result : results) {
            vResults.add(func.apply(result));
        }

        return vResults;
    }

    <T> T sumResults(ArrayList<Test.Result> results, SumFunc<T> func, T base) {
        T sum = base;

        for (Test.Result result : results) {
            sum = func.apply(result, base);
        }

        return sum;
    }
}

interface Func<T> {
    public T apply(Test.Result r);
}

interface SumFunc<T> {
    public T apply(Test.Result r, T carry);
}

class AverageDistanceFromCenter extends TestVisitor {

    String metricKey() {
        return "AverageDistance";
    }

    Long acceptTest(Test test) {
        SumFunc<Float> func = new SumFunc<Float>() {
            public Float apply(Test.Result r, Float sum) { return sum + r.getDist(); }
        };

        float totalDist = sumResults(test.getResults(), func, 0f);
        float avgDist = totalDist / test.getResults().size();

        return (long) avgDist;
    }
}

class FittzVisitor extends TestVisitor {
    String metricKey() {
        return "Fittz";
    }

    Long acceptTest(Test test) {
        SumFunc<Long> func = new SumFunc<Long>() {
            public Long apply(Test.Result r, Long sum) {
                return sum + r.getFittz();
            }
        };
        long totalFittz = sumResults(test.getResults(), func, 0L);
        long avgFittz = totalFittz / test.getResults().size();

        return avgFittz;
    }
}

class ResponseTimeVisitor extends TestVisitor {
    String metricKey() {
        return "ResponseTime";
    }

    Long acceptTest(Test test) {
        SumFunc<Long> func = new SumFunc<Long>() {
            public Long apply(Test.Result r, Long sum) {
                return sum + r.getResponseTime();
            }
        };
        long totalResponseTime = sumResults(test.getResults(), func, 0L);
        long avgResponseTime = totalResponseTime / test.getResults().size();

        return avgResponseTime;
    }
}

class ActionTimeVisitor extends TestVisitor {
    String metricKey() {
        return "ActionTime";
    }

    Long acceptTest(Test test) {
        SumFunc<Long> func = new SumFunc<Long>() {
            public Long apply(Test.Result r, Long sum) {
                return sum + r.getActionTime();
            }
        };
        long totalActionTime = sumResults(test.getResults(), func, 0L);
        long avgActionTime = totalActionTime / test.getResults().size();

        return avgActionTime;
    }
}

class TimeToClickVisitor extends TestVisitor {
    String metricKey() {
        return "TimeToClick";
    }

    Long acceptTest(Test test) {
        SumFunc<Long> func = new SumFunc<Long>() {
            public Long apply(Test.Result r, Long sum) {
                ArrayList<Pair<Long, Point>> path = r.getPath();
                return sum + path.get(path.size()-1).left - path.get(0).left;
            }
        };
        long totalTimeToClick = sumResults(test.getResults(), func, 0L);
        long avgTimeToClick = totalTimeToClick / test.getResults().size();

        return avgTimeToClick;
    }
}
