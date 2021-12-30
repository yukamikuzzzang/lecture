package e20211228.Exceptions;

public class ManyThrows {
    public static void main(String[] args) {

        ManyThrows manyThrows = new ManyThrows();

        try {
            manyThrows.firstMethod();
        } catch (Exception e) {
            e.printStackTrace();
        }
//        finally {
//            System.out.println("end");
//        }

    }

    public void firstMethod() throws Exception{
        System.out.println("1");
        secondMethod();
    }

    public void secondMethod() throws Exception{
        System.out.println("2");
        thirdMethod();
    }

    public void thirdMethod() throws Exception{
        System.out.println("3");
        System.out.println("10 / 0 = " + (10 / 0));
    }
}

