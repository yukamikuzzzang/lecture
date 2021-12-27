package e20211227.packageGetterSetter.privateGetterSetter;
/*17강*/
public class MainClass {
    public static void main(String[] args){
        Student student1 = new Student("홍길동",90);
        student1.getInformation();

        student1.setScore(54);
        student1.getInformation();
    }
}
