package e20211227.interfaces.toy;

public class MainClass {
    public static void main(String[] args){

        Toy robot = new ToyRobot();
        Toy airplane = new ToyAirplane();

        Toy toys[] = {robot, airplane};

        for (int i = 0; i < toys.length; i++){
            toys[i].walk();
            toys[i].running();
            toys[i].alarm();
            toys[i].light();
        }
    }
}
