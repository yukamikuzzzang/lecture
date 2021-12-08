package e20211208;

public class MainClass {
    public static void main(String[] args){
        char c = 'a';
        System.out.println("c = " + c);
        //2byte
        int i = 10;
        System.out.println("i = " + i);
        //4byte
        double d = 10.123;
        System.out.println("d = "+ d);
        //16byte
        boolean b = true; //false;
        System.out.println("b = "+b);

        String s = "Hello Java World!!!!"; //많이 쓰기에 생성과정 생략가능

        String str = new String(); //String 객체 생성
        System.out.println("s = "+s);
        //우리 눈에 보이지 않지만 메모리는 할당되고 있다..!

        s = "Good";
        System.out.println("s =" + s);
        //변수에 담은 건 언제든지 변경이 가능하다.


    }
}
