package e20211227.interfaces.toy;

public class ToyRobot implements Toy{
    @Override
    public void walk() {
        System.out.println("The robot can walk.");
    }

    @Override
    public void running() {
        System.out.println("The robot can run.");
    }

    @Override
    public void alarm() {
        System.out.println("The robot has an alarm function.");
    }

    @Override
    public void light() {
        System.out.println("The robot has a light function.");
    }
}
