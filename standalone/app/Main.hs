module Main (main) where

import Flow ((|>))
import System.Environment (getArgs,getProgName)
import Text.Printf (printf)

import MortgageCalc (calcAmortization,calcMonthlyPayment,showAmortization,showMonthlyPayment)

main = getArgs >>= \args -> getProgName >>= \progName ->
  case args of
    [loan,annualInterestRate,years] ->
      let (l,i,n) = readArgs loan annualInterestRate years
      in calcMonthlyPayment l i n |> showMonthlyPayment n
    ["-v",loan,annualInterestRate,years] ->
      let (l,i,n) = readArgs loan annualInterestRate years
          p = calcMonthlyPayment l i n
          a = calcAmortization p l i n
      in showMonthlyPayment n p ++ "\n" ++ showAmortization a
    otherwise -> showUsage progName
  |> putStr

readArgs :: String -> String -> String -> (Float,Float,Int)
readArgs loan annualInterestRate years = (read loan,(read annualInterestRate) / 100,read years)

showUsage progName =
  printf "Usage: %s [-v] <loan> <annualInterestRate> <years>\n\
         \For example, %s 400000 4.5 30\n" progName progName
