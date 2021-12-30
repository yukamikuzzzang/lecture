package e20211227.abstractClass.bank;

public class MainClass {
    public static void main(String[] args) {
        Bank myBank = new MyBank("박찬호","123-4567-8901",10);

        myBank.deposit();
        myBank.withdraw();
        myBank.installmentSavings();
        myBank.cancellation();

        System.out.println();

        myBank.getKnowledge();

    }
}
