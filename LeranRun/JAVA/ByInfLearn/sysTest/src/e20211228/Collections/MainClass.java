package e20211228.Collections;
/*25강*/
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Stack;

public class MainClass {
    public static void main(String[] args){

        //ArrayList 객체 생성
        ArrayList<String> list = new ArrayList<String>();
        System.out.println("list.size : " + list.size());

        //데이터 추가
        list.add("Hello");
        list.add("Java");
        list.add("World");
        System.out.println("list.size : "+list.size());
        System.out.println("list : "+list);

        list.add(2,"Programming"); //추가
        System.out.println("list : "+list);

        list.set(1,"C");    //변경
        System.out.println("list : "+list);

        //데이터 추출(해당 부분을 출력만 함)
        String str = list.get(2);
        System.out.println("list.get(2) : "+str);
        System.out.println("list : "+list);

        //데이터 제거
        str = list.remove(2);
        System.out.println("list.remove(2) : "+ str);
        System.out.println("list : "+list);

        //데이터 전체 제거(틀은 남음)
        list.clear();
        System.out.println("list : "+list);

        //데이터 유무
        boolean b =list.isEmpty();
        System.out.println("list.isEmpty() : "+b);
        System.out.println(" ===================== " );

        //HashMap 객체 생성
        HashMap<Integer, String> map = new HashMap<Integer,String>();
        System.out.println("map.size() : "+ map.size());

        //데이터 추가
        map.put(5, "Hello");
        map.put(6, "Java");
        map.put(7, "World");
        System.out.println("map : "+map);
        System.out.println("map.size() : "+map.size());

        map.put(8, "!!");
        System.out.println("map : "+map);

        //데이터 교체, map.size() 동일
        map.put(6,"C");
        System.out.println("map : "+map);

        //데이터 추출, 해당하는 데이터 출력
        str = map.get(5);
        System.out.println("map.get(5) :"+ str);

        //데이터 제거
        str = map.remove(8);
        System.out.println(str);
        System.out.println("map : "+map);

        //특정 데이터 포함 유무, ContainsKey() ... boolean 값으로 리턴.
        b = map.containsKey(7);
        System.out.println("map.containsKey(7) : "+b);

        //데이터 전체 제거
        map.clear();
        System.out.println("map : "+ map);

        //데이터 유무
        b = map.isEmpty();
        System.out.println("map.isEmpty() : "+b);


    }
}
