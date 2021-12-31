package e20211227.packageGetterSetter.anotherpackage.calculate;

public class Calculate<value> {

    static int value;
    private String name;
    //외부로부터 변질되지 않도록 보호. /*17강*/
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
