package e20211222.Class;

public class Bicycle {
    public String color;
    public int price;

    public Bicycle(){
        System.out.println("Bicycle constructor");
    }

    //인자가 요구되는 생성자
    public Bicycle(String c, int p){
        System.out.println("Bicycle constructor");
        color = c;
        price = p;
    }
    public void info() {
        System.out.println("-- info() --");
        System.out.println("color : " + color);
        System.out.println("price :  "+ price);
    }
    //JVM이 가장 먼저 찾는 곳..! 메인 메소드가 필요.
}
