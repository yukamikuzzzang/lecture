package e20211227.interfaces;
/*20강*/
public class InterfaceClass implements InterfaceA, InterfaceB{

    public InterfaceClass(){
        System.out.println("-- InterfaceClass Constructor --");
    }
    @Override //재정의
    public void funA() {
        //interfaceA
        System.out.println("-- funA() --");
    }

    @Override
    public void funB() {
        //interfaceB
        System.out.println("-- funB() --");
    }
}
