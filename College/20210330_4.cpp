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
	cout<<"회원명: 길동, 계좌번호: "<<b<<endl; 
}

void Bank::select(){
	cout<<"회원명: "<<name<< ", 계좌번호: "<<anum<<"비밀번호: "<<pw<<endl;
}

int Bank::inputPass(){
	string password;
	
	cout<<"계좌번호: "<<anum<<endl;
	cout<<"비밀번호: "; 
	
	password = getch(); //1문자입력, 안보임
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
	
	//cout<<"비밀번호:"<<password<<endl;
	
	if(pw == password){
		return 1;
	} else{
		return 0;
	}

}

int Bank::putMoney(int d){	
	inMoney = inMoney + d;
	cout<<"현재금액: "<<inMoney<<endl;
}

int Bank::getMoney(int e){
	if(inMoney- e <0){
		cout<<"잔액이 부족합니다. /현재금액: "<<inMoney<<endl; 
	}else{
		inMoney = inMoney - e;
		cout<<"현재금액: "<<inMoney<<endl;
	}	
}


int Bank::moneyNow(){
	cout<<"현재금액: "<<inMoney<<endl;
}

int main(){
	int con = 0;
	int money = 0;
	
	Bank bk("홍길동","111-1111","1234");
	
	cout<<"********************"<<endl;
	cout<<"**은행관리프로그램**"<<endl;
	cout<<"********************"<<endl;
	
	
	
	while(1){
		
		
		cout<<"1.회원보기"<<endl;
		cout<<"2.입금"<<endl;
		cout<<"3.출금"<<endl;
		cout<<"4.잔액보기"<<endl;
		cout<<"5.나가기"<<endl;
		cout<<"선택하세요>> "; 

		cin>>con;
		
		
		switch(con)
		{
		case 1:
			bk.select();
			cout<<"조회완료"<<endl;
			break;
			
		case 2:
			if(bk.inputPass() == 1){
				cout<<"입금할 금액: ";
				cin>>money;
				bk.putMoney(money);
			}else{
				cout<<"비밀번호가 틀렸습니다."<<endl;
			}
			break;
			
		case 3:
			if(bk.inputPass() == 1){
				cout<<"입금할 금액: ";
				cin>>money;
				bk.getMoney(money);
			}else{
				cout<<"비밀번호가 틀렸습니다."<<endl;
			}
			break;
	
		case 4:
			bk.moneyNow();
			break;
			
		case 5:
			break;
			
		default:
			cout<<"다시 입력해주세요."<<endl;
			break;
			
		}
		if(con>4){
			break;
		}
	}	

	return 0;
}
