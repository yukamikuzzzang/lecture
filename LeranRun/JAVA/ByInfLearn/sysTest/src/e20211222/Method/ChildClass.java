package e20211222.Method;

public class ChildClass {
    public String name;
    public String gender;
    public int age;

    public ChildClass(){
        System.out.println("-- ChildClass constructor --");
    }

    public void setInfo(String n, String g, int c){
        System.out.println("--setInfo() START --");
        name = n;
        gender = g;
        age = c;
    }
    //method
    public void getInfo(){
        System.out.println("-- getInfo() START --");
        System.out.println("name : "+ name);
        System.out.println("gender : "+ gender);
        System.out.println("age : "+ age);
    }
    //method overloading
    public void getInfo(String n, int c){
        System.out.println();
        System.out.println("-- getInfo II --");
        System.out.println("name : " + n);
        System.out.println("gender : " + gender);
        System.out.println("age : "+ c);
    }

    public void getInfo(String n, String g, int c){
        System.out.println();
        System.out.println("-- getInfo III --");
        System.out.println("name : " + n);
        System.out.println("gender : " + g);
        System.out.println("age : "+ c);
    }
    //접근(지정)자..
    private void mySecret(){
        System.out.println("-- mySecret() --");
    }
}
