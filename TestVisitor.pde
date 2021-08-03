abstract class TestVisitor {
    abstract Float acceptTest1(Test1 test);
    abstract Float acceptTest2(Test2 test);
    abstract Float acceptTest3(Test3 test);
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

    Float acceptTest1(Test1 test) {
        SumFunc<Float> func = new SumFunc<Float>() {
            public Float apply(Test.Result r, Float sum) { return sum + r.getDist(); }
        };

        float totalDist = sumResults(test.getResults(), func, 0f);
        float avgDist = totalDist / test.getResults().size();

        return avgDist;
    }

    Float acceptTest2(Test2 test) {
        // TODO(zaci): Implement Me
        return -1f;
    }
    Float acceptTest3(Test3 test) {
        // TODO(zaci): Implement Me
        return -1f;
    }
}

class TimeToClickVisitor extends TestVisitor {
    String metricKey() {
        return "TimeToClick";
    }

    Float acceptTest1(Test1 test) {
        SumFunc<Float> func = new SumFunc<Float>() {
            public Float apply(Test.Result r, Float sum) {
                return sum + r.timeToClick();
            }
        };
        float totalTimeToClick = sumResults(test.getResults(), func, 0f);
        float avgTimeToClick = totalTimeToClick / test.getResults().size();

        return avgTimeToClick;
    }

    Float acceptTest2(Test2 test) {
        // TODO(zaci): Implement Me
        return -1f;
    }
    Float acceptTest3(Test3 test) {
        // TODO(zaci): Implement Me
        return -1f;
    }
}
