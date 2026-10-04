//+------------------------------------------------------------------+
//| My AI Trading Bot - Version 1                                   |
//+------------------------------------------------------------------+
#property strict

#include <Trade/Trade.mqh>

CTrade trade;

input int EMA_Period = 50;
input int RSI_Period = 14;

int emaHandle;
int rsiHandle;

int OnInit()
{
   emaHandle = iMA(_Symbol, PERIOD_M15, EMA_Period, 0, MODE_EMA, PRICE_CLOSE);
   rsiHandle = iRSI(_Symbol, PERIOD_M15, RSI_Period, PRICE_CLOSE);

   if(emaHandle == INVALID_HANDLE || rsiHandle == INVALID_HANDLE)
      return INIT_FAILED;

   return INIT_SUCCEEDED;
}

void OnTick()
{
   double ema[];
   double rsi[];

   if(CopyBuffer(emaHandle, 0, 0, 1, ema) <= 0)
      return;

   if(CopyBuffer(rsiHandle, 0, 0, 1, rsi) <= 0)
      return;

   double price = SymbolInfoDouble(_Symbol, SYMBOL_BID);

   if(price > ema[0] && rsi[0] > 55)
   {
      Comment("SIGNAL: BUY\nEMA: UP\nRSI: ", rsi[0]);
   }
   else if(price < ema[0] && rsi[0] < 45)
   {
      Comment("SIGNAL: SELL\nEMA: DOWN\nRSI: ", rsi[0]);
   }
   else
   {
      Comment("SIGNAL: WAIT\nRSI: ", rsi[0]);
   }
}
