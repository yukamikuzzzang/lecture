package e20211227.packageGetterSetter;
import e20211227.packageGetterSetter.anotherpackage.calculate.*;
/*16강*/
public class PackageMainClass {
    public static void main(String[] args){

        Calculate cal1 = new Calculate("영서비");
        Calculate cal2 = new Calculate("휘버미");

        cal1.setSum(10);
        cal2.setSum(100);
        cal1.getSum();

    }
}
