package e20211222.Method;
/*13강*/
//JVM이 먼저 찾을 곳.
public class MainClass {
    public static void main(String[] args){

        ChildClass child1 = new ChildClass();
        //객체에 대한 속성을 부여하지 않음.
        //child1.name = "홍길동";
        //child1.gender = "M";
        //child1.age = 20;

        child1.setInfo("hong gil dong", "M", 20);
        child1.getInfo();
        child1.getInfo("sys",25);

        ChildClass child2 = new ChildClass();
        child2.getInfo("Hatsune Miku","F", 17);
        child2.getInfo(); //값이 정해진 건 아님.

        //child1.mySecret();
        //외부에서 호출 불가.
    }
}
