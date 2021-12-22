package e20211222.Finalize;

import e20211222.ConStructor.ObjectClass;

/*15강 소멸자*/
public class MainClass {
    public static void main(String[] args){
    //소멸자
        ObjectEx obj4;

        obj4 = new ObjectEx();
        obj4 = new ObjectEx();

        System.gc();
    }
}
