package e20211228.Networking.bidrectional;

import java.net.Socket;

public class MainClassClient {
    public static void main(String[] args) {
        Socket socket = null;

        try {
            socket = new Socket("localhost", 9000); //127.0.0.1 = localhost
            System.out.println("서버 연결~~");
            System.out.println("socket : " + socket);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (socket != null) socket.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

    }
    /*예외처리 제외하면 딱 두 줄*/
    /*서버를 먼저 구동시키고 클라이언트를 실행시키자.*/
}
