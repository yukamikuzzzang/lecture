package e20211227.abstractClass;

public class ClassEx extends AbstractClassEx{
    public ClassEx(){
        System.out.println("ClassEx Constructor");
    }

    public ClassEx(int i, String s){
        super(i,s);
    }

    @Override
    public void fun2() {
        System.out.println("-- fun2() START --");
    }

}
