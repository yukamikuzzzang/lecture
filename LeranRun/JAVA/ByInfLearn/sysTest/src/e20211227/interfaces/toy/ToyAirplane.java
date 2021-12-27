package e20211227.interfaces.toy;

public class ToyAirplane implements Toy {
    @Override
    public void walk() {
        System.out.println("The airplane can not walk.");
    }

    @Override
    public void running() {
        System.out.println("The airplane can not run.");
    }

    @Override
    public void alarm() {
        System.out.println("The airplane has alarm function.");
    }

    @Override
    public void light() {
        System.out.println("The airplane has no light function.");
    }
}
