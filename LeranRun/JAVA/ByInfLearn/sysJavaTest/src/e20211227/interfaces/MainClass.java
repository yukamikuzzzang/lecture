package e20211227.interfaces;

public class MainClass {
    public static void main(String[] args) {
        InterfaceA ia = new InterfaceClass();
        InterfaceB ib = new InterfaceClass();

        ia.funA(); //funB는 접근불가. 데이터형이 InterfaceA니까
        ib.funB();
    }
}
