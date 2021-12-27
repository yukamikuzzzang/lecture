package e20211227.anotherpackage.calculate;

public class Calculate<value> {

    static int value;
    String name;
    public Calculate() {

    }

    public Calculate(String name){
        this.name = name;

    };

    public void setSum(int value){
        this.value += value;

    }

    public void getSum(){
        System.out.println("\n합: "+this.value+"\n");
    }
}
