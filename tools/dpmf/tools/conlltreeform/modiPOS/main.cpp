#include <iostream>
#include <fstream>
#include <string>
#include <sstream>
#include <strstream>
#include <vector>
#include<algorithm>
#include <stdlib.h>
using namespace std;

class CToken        
{                   
    public:
        string word;
        string POS;
        int father;
 };        
class CDepNode 
{   
    public: 
        vector<int> leftMods;
        vector<int> rightMods;
}; 

vector<string> split(const string& src, string delimit)
{
    vector<string> r;
    int f = 0;
    int p = -1;

    while ((p = (int)src.find(delimit, p + 1)) != (int)string::npos)
    {
        if (p > f)
            r.push_back(src.substr(f, p - f));				
        f = p + (int)delimit.size();
    }
    p = (int)src.size();
    if (p > f)
        r.push_back(src.substr(f, p - f));				
    return r;
}
vector<CDepNode> treeInit(vector<CToken> &m_vToken, int &root)
{
    vector<CDepNode> nodes;        
    vector<int> left,right;
    CDepNode tmp;
    tmp.leftMods = left;
    tmp.rightMods = right;
    for(int i=0; i<m_vToken.size(); i++) 
        nodes.push_back(tmp);
    for(int i=0; i<m_vToken.size(); i++)
    {
        if(m_vToken[i].father == -1)
            root = i;
        else 
        {
            if(i < m_vToken[i].father)
                (nodes[m_vToken[i].father].leftMods).push_back(i);
            else
                (nodes[m_vToken[i].father].rightMods).push_back(i);
        }   
    }
    for(int i=0; i<nodes.size(); i++)
    {;
        //cout<<i+1<<": ";
        //for(int j=0; j<nodes[i].leftMods.size(); j++)
        //    cout<<nodes[i].leftMods[j]+1<<" ";
        //for(int j=0; j<nodes[i].rightMods.size(); j++)
        //    cout<<nodes[i].rightMods[j]+1;
        //cout<<endl;
        //reverse(nodes[i].leftMods.begin(),nodes[i].leftMods.end());
        //reverse(nodes[i].rightMods.begin(),nodes[i].rightMods.end());
        
        }
    return nodes;
}
string GenTree(vector<CDepNode> &nodes, int &root, vector<CToken> &m_vToken)
{   
    string tree;
    int kid;

    //for (kid = int(nodes[root].leftMods.size()) - 1; kid >= 0; --kid)
    for (kid = 0; kid<int(nodes[root].leftMods.size()); kid++)
    {
        tree += "("
             + GenTree(nodes, nodes[root].leftMods[kid], m_vToken)
             + ") ";
    }
    
    tree += m_vToken[root].word + "/" + m_vToken[root].POS;

    for (kid = 0; kid < int(nodes[root].rightMods.size()); ++kid)
    {
        tree += " ("
             + GenTree(nodes, nodes[root].rightMods[kid],m_vToken)
             + ")";
    }

     return tree;
}
vector<string> forpos(string line)
{
    vector<string> vpostmp = split(line," ");
    vector<string> vpos;
    for(int i=0; i<vpostmp.size(); i++)
    {
        vector<string> tmp = split(vpostmp[i],"/");
        vpos.push_back(tmp[tmp.size()-1]);
        }
    return vpos;
}
int main(int argc, char * argv[]){	
	//cout<<"./treeForm connllFormTree.file"<<endl;

	if(argc<3){
		cerr<<"wrong parameters"<<endl;
	}

	ifstream in(argv[1]);
	ifstream inpos(argv[2]);
	vector<CToken> m_vToken;
    string line,lpos;
    string word;
    getline(inpos,lpos);
    vector<string> vpos = forpos(lpos); 
    
    int cnt=0;
    while(getline(in,line))
    {
        if(line.size()>2)
        {
            vector<string> vec = split(line,"\t");
            CToken tmp;
            tmp.word = vec[0];
            tmp.POS = vpos[cnt];
            cnt++;
            tmp.father = atoi(vec[2].c_str())-1;
            m_vToken.push_back(tmp);
        }
        else//end of one sentence
        {
            cnt=0;
            getline(inpos,lpos);
            vpos.clear();
            vpos = forpos(lpos);
            int root;
            vector<CDepNode> nodes = treeInit(m_vToken,root);
            string tree = GenTree(nodes, root, m_vToken);
            cout<<"("+tree+")"<<endl;;
            m_vToken.clear();
            
        }
   }

    return 0;
}
