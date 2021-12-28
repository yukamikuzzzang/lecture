package e20211228.String;

public class MainClass {
    public static void main(String[] args){
        //String str = "JAVA";
        String str = new String("JAVA");
        System.out.println("str : "+str);

        str = str + "_8";
        System.out.println("str : "+str);

        //StringBuffer
        StringBuffer sf = new StringBuffer("JAVA");
        System.out.println("sf : "+sf);
        sf.append(" World");
        System.out.println("sf : "+sf);
        System.out.println("sf.length() : "+sf.length());
        sf.insert(sf.length(),"~~~~");
        System.out.println("sf : "+sf);
        sf.delete(4, 8);
        System.out.println("sf : "+sf);

        //StringBuilder
        StringBuilder sb = new StringBuilder("JAVA WORLD!!");
        System.out.println("sb : "+sb);

        sb.append("_8");
        System.out.println("sb : "+sb);
        sb.delete(1,4);
        System.out.println("sb : "+sb);
        sb.insert(1,"WA!");
        System.out.println("sb : "+sb);

    }
}
