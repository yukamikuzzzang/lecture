package e20211228.Exceptions;

/*26강*/
public class MainClass {
    public static void main(String[] args) {
        int i = 10;
        int j = 0;
        int r = 0;

        System.out.println("Exception BEFORE");
        try {
            r = i / j; //에러 발생. 시스템 멈춤.
        } catch (Exception e) {
            e.printStackTrace();
            String msg = e.getMessage();
            System.out.println("msg: "+ msg);
        }
        System.out.println("Exception AFTER");
    }
}
