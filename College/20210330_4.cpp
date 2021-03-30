#include<iostream>
#include<string>
#include<windows.h>
#include<conio.h>
using namespace std;
class Bank{
	private:
		string name;
		string anum;
		string pw;
		int inMoney;
	public:
		Bank(string a,string b,string c);
		void select(); 
		int putMoney(int d);
		int getMoney(int e);
		int moneyNow();
		int inputPass();
};

Bank::Bank(string a,string b, string c){
	name = a;
	anum = b;
	pw = c;
	inMoney = 0;
	cout<<"ȸ����: �浿, ���¹�ȣ: "<<b<<endl; 
}

void Bank::select(){
	cout<<"ȸ����: "<<name<< ", ���¹�ȣ: "<<anum<<"��й�ȣ: "<<pw<<endl;
}

int Bank::inputPass(){
	string password;
	
	cout<<"���¹�ȣ: "<<anum<<endl;
	cout<<"��й�ȣ: "; 
	
	password = getch(); //1�����Է�, �Ⱥ���
	cout<<'\b';
	putchar('*');
	while(getch() != '\t'){
		password+=getch();
		cout<<' '<<'\b';
		putchar('*');
	}
//	password+=getch();
//	cout<<' '<<'\b';
//	putchar('*');
//	password+=getch();
//	cout<<' '<<'\b';
//	putchar('*');
//	cout<<endl;
	
	//cout<<"��й�ȣ:"<<password<<endl;
	
	if(pw == password){
		return 1;
	} else{
		return 0;
	}

}

int Bank::putMoney(int d){	
	inMoney = inMoney + d;
	cout<<"����ݾ�: "<<inMoney<<endl;
}

int Bank::getMoney(int e){
	if(inMoney- e <0){
		cout<<"�ܾ��� �����մϴ�. /����ݾ�: "<<inMoney<<endl; 
	}else{
		inMoney = inMoney - e;
		cout<<"����ݾ�: "<<inMoney<<endl;
	}	
}


int Bank::moneyNow(){
	cout<<"����ݾ�: "<<inMoney<<endl;
}

int main(){
	int con = 0;
	int money = 0;
	
	Bank bk("ȫ�浿","111-1111","1234");
	
	cout<<"********************"<<endl;
	cout<<"**����������α׷�**"<<endl;
	cout<<"********************"<<endl;
	
	
	
	while(1){
		
		
		cout<<"1.ȸ������"<<endl;
		cout<<"2.�Ա�"<<endl;
		cout<<"3.���"<<endl;
		cout<<"4.�ܾ׺���"<<endl;
		cout<<"5.������"<<endl;
		cout<<"�����ϼ���>> "; 

		cin>>con;
		
		
		switch(con)
		{
		case 1:
			bk.select();
			cout<<"��ȸ�Ϸ�"<<endl;
			break;
			
		case 2:
			if(bk.inputPass() == 1){
				cout<<"�Ա��� �ݾ�: ";
				cin>>money;
				bk.putMoney(money);
			}else{
				cout<<"��й�ȣ�� Ʋ�Ƚ��ϴ�."<<endl;
			}
			break;
			
		case 3:
			if(bk.inputPass() == 1){
				cout<<"�Ա��� �ݾ�: ";
				cin>>money;
				bk.getMoney(money);
			}else{
				cout<<"��й�ȣ�� Ʋ�Ƚ��ϴ�."<<endl;
			}
			break;
	
		case 4:
			bk.moneyNow();
			break;
			
		case 5:
			break;
			
		default:
			cout<<"�ٽ� �Է����ּ���."<<endl;
			break;
			
		}
		if(con>4){
			break;
		}
	}	

	return 0;
}
