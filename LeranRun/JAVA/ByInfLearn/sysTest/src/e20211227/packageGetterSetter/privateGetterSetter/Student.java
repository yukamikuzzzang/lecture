package e20211227.packageGetterSetter.privateGetterSetter;

public class Student {

    private String name;
    private int score;

    //속성에 데이터를 리턴받음
    public String getName() {
        return name;
    }

    //받은 값을 멤버 변수에 넣음.
    //아이디 변경이 안되는 경우 setter를 막아둠.
//    public void setName(String name) {
//        this.name = name;
//    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        //안전장치
        if(score >50) this.score = score;

    }

    public Student(String n, int s){
        this.name = n;
        this.score = s;
    }

    public void getInformation(){
        System.out.println(" -- getInfo() --");
        System.out.println(" name : " + name);
        System.out.println(" score : " + score);
    }
}
