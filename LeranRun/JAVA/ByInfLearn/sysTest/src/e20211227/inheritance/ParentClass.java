package e20211227.inheritance;
/*18강*/
public class ParentClass {

    public ParentClass(){
        System.out.println("ParentClass Constructor");
    }

    public void parentFun(){
        System.out.println("parentFun()");
    }

    private void privateFun(){
        System.out.println("privateFun()");
    }

    public void makeJJajang(){
        System.out.println(" -- makeJJajang() --");
    }

    int openYear = 1998;
    
}
