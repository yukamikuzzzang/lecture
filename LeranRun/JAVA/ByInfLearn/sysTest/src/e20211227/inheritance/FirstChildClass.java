package e20211227.inheritance;

public class FirstChildClass extends ParentClass {

    public FirstChildClass(){
        System.out.println("FirstChildClass Constructor");
    }

//    public void childFun(){
//        System.out.println("childFun()");
//    }

    @Override
    public void makeJJajang(){
        System.out.println(" -- FirstChildClass's makeJJajang() --");
    }
}
