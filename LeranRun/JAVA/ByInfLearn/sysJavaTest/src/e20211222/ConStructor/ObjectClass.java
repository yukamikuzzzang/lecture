package e20211222.ConStructor;

public class ObjectClass {
    /*
    public ObjectClass(){
        System.out.println("-- ObjectClass() --");
    }*/

    //사용자 정의 생성자가 있다면 기본이 따로 생성되지 않음.
    public ObjectClass(int x){

    }

    public ObjectClass(String s, int[] iArr){
        System.out.println("-- ObjectClass() --");
        System.out.println("s --->" + s);
        System.out.println("iArr --->" + iArr);
    }

    //전역변수
    public int x;
    public int y;

    public ObjectClass(int x, int y){ //지역변수: 파라미터
        this.x = x;  //전역변수 = 지역변수
        this.y = y;
        //this. ||ObjectClass에서 작업중인 객체를 가리킴(나 자신)
    }

    public void getInfo() {
        System.out.println("x --->" + this.x);
        System.out.println("y --->" + this.y);
        //전역변수임을 아는 것이 그리 어렵지 않음.
        //this를 굳이 넣어줄 필욘 없음.
    }
}
