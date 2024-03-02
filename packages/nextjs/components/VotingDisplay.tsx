import React, { useState, useEffect } from 'react';
import DistrictManager from "../../hardhat/deployments/sapphire-testnet/DistrictManager.json";
import { readContract } from "@wagmi/core";

type Vote = {
    name: string;
    description: string;
    address: number;
    hasVoted: boolean;
}

function Votes() {
  let voteInfo: Vote[] = [];
   
  let results: string = "";
  useEffect(() => {
    const fetchData = async () => {
      try {
        // Your asynchronous operation, for example fetching data from an API
        const result = await readContract({
            address: DistrictManager.address,
            abi: DistrictManager.abi,
            functionName: "getVotes",
          });
        
        results = JSON.stringify(result);
          
      } catch (error) {
        console.error('Error fetching data:', error);
      }
    };

    fetchData(); // Trigger the asynchronous function
  }, []); // Empty dependency array ensures this effect runs only once

  return (
    <div>
      {/* Render your component using the data */}
      {results ? (
        <div>
          {/* Display the fetched data */}
          <p>{results}</p>
        </div>
      ) : (
        <p>Loading...</p>
      )}
    </div>
  );
}

export default Votes;