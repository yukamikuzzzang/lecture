package e20211227.inheritance;

public class SecondChildClass extends ParentClass {

    public SecondChildClass(){
        System.out.println("SecondChildClass Constructor");
    }

//    public void childFun(){
//        System.out.println("childFun()");
//    }

    @Override
    public void makeJJajang(){
        System.out.println(" -- SecondChildClass makeJJajang() --");
    }
}
