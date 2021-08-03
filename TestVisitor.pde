abstract class TestVisitor {
    abstract void acceptTest1(Test1 test);
    abstract void acceptTest2(Test2 test);
    abstract void acceptTest3(Test3 test);

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


    void acceptTest1(Test1 test) {
        SumFunc<Float> func = new SumFunc<Float>() {
            public Float apply(Test.Result r, Float sum) { return sum + r.getDist(); }
        };

        float totalDist = sumResults(test.getResults(), func, 0f);
        float avgDist = totalDist / test.getResults().size();

        println("AVG DISTANCE: " + avgDist);
    }

    void acceptTest2(Test2 test) {
        // TODO(zaci): Implement Me
    }
    void acceptTest3(Test3 test) {
        // TODO(zaci): Implement Me
    }
}

class TimeToClickVisitor extends TestVisitor {
    
    void acceptTest1(Test1 test) {
        SumFunc<Float> func = new SumFunc<Float>() {
            public Float apply(Test.Result r, Float sum) {
                return sum + r.timeToClick();
            }
        };
        float totalTimeToClick = sumResults(test.getResults(), func, 0f);
        float avgTimeToClick = totalTimeToClick / test.getResults().size();

        println("AVG FITTZ: " + avgTimeToClick + "s");
    }

    void acceptTest2(Test2 test) {
        // TODO(zaci): Implement Me
    }
    void acceptTest3(Test3 test) {
        // TODO(zaci): Implement Me
    }
}
