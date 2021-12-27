package e20211227.inheritance;

public class ChildClass extends ParentClass {

    public ChildClass(){
        System.out.println("FirstChildClass Constructor");
    }

    public void childFun(){
        System.out.println("childFun()");
    }

    @Override
    public void makeJJajang(){
        System.out.println(" -- FirstChildClass's makeJJajang() --");
    }

    int openYear = 2022;

    public void getOpenYear() {
        System.out.println("ChildClass's Open year : "+ this.openYear);
        System.out.println("ParentClass's Open year : " + super.openYear);
    }

}
