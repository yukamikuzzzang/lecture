package e20211207;

public class MainClass {
    public static void main(String[] args){
        int i = 10; //선언과 초기화를 같이
        int j;      //선언
        j = 100;    //초기화

        i = 200;    //나중 것으로 초기화

        System.out.println("i + j = "+(i+j));
        System.out.println("i + j = "+i+j);
        //이클립스 기준 Ctrl+F11
        //바로 실행

        int x = 10;
        System.out.println(x);

        x = 100;
        System.out.println(x);

        x = 300;
        System.out.println(x);

        x = 0;
        System.out.println(x);
        //선언은 한 번만
        //초기화한 변수는 여러가지로 사용할 수 있다.
    }
}