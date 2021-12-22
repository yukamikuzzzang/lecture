package e20211222.ConStructor;
/*15강 Con + this. */
public class MainClass {
    public static void main(String[] args){
        ObjectClass obj1 = new ObjectClass(10);

        int[] iArr = {10,20,30};
        ObjectClass obj2 = new ObjectClass("Hello", iArr);

        ObjectClass obj3 = new ObjectClass(10, 20);
        obj3.getInfo();
    }
}
