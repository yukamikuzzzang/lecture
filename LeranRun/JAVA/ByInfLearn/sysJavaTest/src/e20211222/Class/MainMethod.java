package e20211222.Class;
/*12강*/
//Grander.class
//Bicycle.class
public class MainMethod {
    public static void main(String[] args) {
        Grandeur myCar1 = new Grandeur(); //생성자 호출, 객체 생성
        myCar1.color = "red";             //.(도트)접근자로 객체변수에 접근
        myCar1.gear = "auto";
        myCar1.price = 100;

        myCar1.run();
        myCar1.stop();
        myCar1.info();
        System.out.println();
        Grandeur myCar2 = new Grandeur();
        myCar2.color = "yellow";
        myCar2.gear = "manual";
        myCar2.price = 299;

        myCar2.run();
        myCar2.stop();
        myCar2.info();

        Bicycle myBicycle = new Bicycle();
        myBicycle.color = "blue";
        myBicycle.price = 39;

        myBicycle.info();

        //클래스를 만들 때 생성자를 여러개 만들어서 객체의 속성을 다양하게 만들 수 있음.
        Bicycle bicycle = new Bicycle("pink",33);
        bicycle.info();         //bicycle.color = "pink";
        bicycle.color = "cyan";
        bicycle.info();         //bicycle.color = "cyan";

    }
}
