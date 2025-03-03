program auction_testnet_onurpolat1.aleo {

    record Bid {
        owner: address,
        bidder: address,
        amount: u64,
        is_winner: bool,
    }

    transition place_bid(bidder: address, amount: u64) -> Bid {
        // Ensure the caller is the auction bidder.
        assert_eq(self.caller, bidder);
        // Return a new 'Bid' record for the auction bidder.
        return Bid {
            owner: aleo1uw8e4nq0clpt9400sz0wdm64psjktqm28jq9c0qaxy7974v8rupqhu44sa,
            bidder: bidder,
            amount: amount,
            is_winner: false,
        };
    }


    transition resolve(first: Bid, second: Bid) -> Bid {
        // Ensure the caller is the auctioneer.
        assert_eq(self.caller, aleo1uw8e4nq0clpt9400sz0wdm64psjktqm28jq9c0qaxy7974v8rupqhu44sa);
        // Resolve the winner of the auction.
        if (first.amount >= second.amount) {
            return first;
        } else {
            return second;
        }
    }


    transition finish(bid: Bid) -> Bid {
        // Ensure the caller is the auctioneer.
        assert_eq(self.caller, aleo1uw8e4nq0clpt9400sz0wdm64psjktqm28jq9c0qaxy7974v8rupqhu44sa);
        // Return 'is_winner' as 'true' in the winning 'Bid'.
        return Bid {
            owner: bid.bidder,
            bidder: bid.bidder,
            amount: bid.amount,
            is_winner: true,
        };
    }
}