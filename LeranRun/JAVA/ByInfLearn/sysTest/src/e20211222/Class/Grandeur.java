package e20211222.Class;

public class Grandeur {
        //속성, 변수 선언
        public String color;
        public String gear;
        public int price;

        public Grandeur() {
            System.out.println("Grandeur constructor");
        }

        public void run(){
            System.out.println("-- run --");
        }

        public void stop(){
            System.out.println("-- stop --");
        }

        public void info(){
            System.out.println("-- info() --");
            System.out.println("color : " + color);
            System.out.println("gear : " + gear);
            System.out.println("price : " + price);
        }
}
