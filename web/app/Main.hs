module Main (main) where

import Control.Monad (liftM)
import GHCJS.DOM (currentDocument)
import GHCJS.DOM.Document (getElementByIdUnsafe)
import GHCJS.DOM.EventM (on)
import GHCJS.DOM.HTMLElement (setInnerText)
import GHCJS.DOM.HTMLInputElement (getValueUnsafe)
import GHCJS.DOM.Types (HTMLInputElement(..),HTMLPreElement(..),unsafeCastTo)

import MortgageCalc (calcAmortization,calcMonthlyPayment,showAmortization,showMonthlyPayment)

import qualified GHCJS.DOM.Element as E (click)

main :: IO ()
main = do
  Just doc       <- currentDocument
  -- input
  loanInput      <- (getElementByIdUnsafe doc "loan" >>= unsafeCastTo HTMLInputElement)
  yearInput      <- (getElementByIdUnsafe doc "year" >>= unsafeCastTo HTMLInputElement)
  interestInput  <- (getElementByIdUnsafe doc "interest" >>= unsafeCastTo HTMLInputElement)
  calcButton     <- getElementByIdUnsafe doc "calc"
  -- output
  output         <- (getElementByIdUnsafe doc "output" >>= unsafeCastTo HTMLPreElement)

  on calcButton E.click $ do
    l <- (liftM read . getValueUnsafe) loanInput
    i <- (liftM (/100) . liftM read . getValueUnsafe) interestInput
    n <- (liftM read . getValueUnsafe) yearInput
    let p = calcMonthlyPayment l i n
        a = calcAmortization p l i n in
      setInnerText output (Just (showMonthlyPayment n p ++ "\n" ++ showAmortization a))

  return ()

