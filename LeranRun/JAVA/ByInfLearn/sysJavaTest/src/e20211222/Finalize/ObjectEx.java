package e20211222.Finalize;

public class ObjectEx {
    public ObjectEx() {
        System.out.println("-- ObjectEx Constructor --");
    }

    @Override
    protected void finalize() throws Throwable {
        System.out.println("-- finalize() method --");
        super.finalize();
    }
}
