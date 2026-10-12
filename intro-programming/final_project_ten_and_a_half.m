% ------------------------------------------------------------------------
% final_project_ten_and_a_half.m
% Final project: text-based "Ten and a Half" (十點半) card game with betting.
% Course: Computer Programming (程式設計), YZU, Spring 2023
% Author: Sheng-Wei Lu (呂聖韡)
% ------------------------------------------------------------------------
%初始設置
chips=20;%籌碼
frequency=0;%局數
cards = [1:10,0.5,0.5,0.5]; % 牌組

%遊戲開始
while chips>0
    
%目前的回數
 frequency=frequency+1;
 disp(['目前局數：', num2str(frequency)])

%詢問下注
 disp(['所剩籌碼：', num2str(chips)])
 wager=input('你要押多少: ');
 while wager > chips
    disp('押注金額不能大於所剩籌碼')
    wager=input('請重新輸入你要押多少: ');
 end   

% 初始化得分
 playerScore = 0; % 玩家得分
 dealerScore = 0; % 莊家得分

% 發第一次卡牌
 playerCards = cards(randi(length(cards),1)); % 玩家手牌
 card=1;%玩家手牌數
 dealerCards = cards(randi(length(cards),1)); % 莊家手牌
 playerScore = sum(playerCards); % 玩家得分
 dealerScore = sum(dealerCards); % 莊家得分

% 玩家抽牌
 while playerScore < 10.5 & card < 5
    disp(['你的得分：', num2str(playerScore)])
    choice = input('是否要牌？（y/n）: ','s');
    if strcmp(choice,'y')
        playerCards = [playerCards, cards(randi(length(cards)))];
        playerScore = sum(playerCards);
        card=card+1;
        disp(['目前的手牌數量：', num2str(card)])
    else
        break;
    end
 end

 if playerScore == 10.5
    disp('十點半，如獲勝將獲得兩倍籌碼')%提示玩家金額翻倍
 end  

%莊家抽牌
 if card<5 & playerScore <= 10.5
  disp('你的回合結束，莊家開始')
  while dealerScore < 7
       disp('莊家抽牌')
       dealerCards = [dealerCards, cards(randi(length(cards)))];
       dealerScore = sum(dealerCards);
  end
 end
%特殊狀況
 if playerScore == 10.5%10.5兩倍
      wager=wager*2;
 else
      wager=wager;
 end  

 if card>=5 & playerScore <= 10.5%過五關三倍
      wager=wager*3;
 else
      wager=wager;
 end  

% 結果公告
 disp(['你的得分：', num2str(playerScore)]);
 disp(['莊家的得分：', num2str(dealerScore)]);

 if card>=5
    chips=chips+wager;
    disp('恭喜過五關!你赢了！你獲得三倍籌碼!') 
     
 elseif playerScore > 10.5
    chips=chips-wager;
    disp('你爆了！莊家赢了！你超可悲!')
    
 elseif dealerScore > 10.5
    chips=chips+wager;
    disp('莊家爆了！你赢了！')
    
 elseif playerScore > dealerScore
    chips=chips+wager;
    disp('你赢了！')
    
 elseif playerScore < dealerScore
    chips=chips-wager;
    disp('你輸了！')
    
 else
    disp('平局！');

 end
end

%整盤結束
disp('已破產!，遊戲結束')
disp(['你總共玩了', num2str(frequency) ,'局'])
