#include <iostream> //전처리기 :입출력 헤더파일 
#include <string>
#include <time.h>
#include <stdlib.h>
using namespace std; //cin. cout, endl...


int main(){
	char board[3][3]={' ',};
	int onex, oney, twox, twoy;
	int x,y;
	int cnt= 0;
	
	for(x=0;x<3;x++){
		for(y=0;y<3;y++){
			//cout<<x<<endl;
			//cout<<y<<endl;
			cout<<board[x][y];
			if(y>=2){
				cout<<endl;
			}
		}
	}
	
	

	while(1){
		
		if(cnt<9){
			cout<<"1player\'s turn!: ";
			cout<<"1\'s X ";
			cin>>onex;
			cout<<"1\'s Y ";
			cin>>oney;
			
			
			if(board[onex][oney] == 't'){
				cout<<"2player가 점령하고 있어요."<<endl;
				continue;
			}else{
				board[onex][oney] = 'o';
				cnt++;
			}
		}
		else{break;}
		
		if(cnt<9){
			cout<<"2player\'s turn!: ";
			cout<<"2\'s X ";
			cin>>twox;
			cout<<"2\'s Y ";
			cin>>twoy;
			
			if(board[twox][twoy] == 'o'){
				cout<<"1player가 점령하고 있어요."<<endl;
			}else{
				board[twox][twoy] = 't';
				cnt++;
			}
		}else{break;}
	}

	return 0;
}
