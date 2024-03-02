"use client";

import { useState } from "react";
import Image from "next/image";
// import BadgeModal from "~~/components/BadgeModal";
import VoteModal from "~~/components/VoteModal";
import Countdown from "~~/components/VotingCountDown";

const Page2 = () => {
  const [isVoteModalOpen, setIsVoteModalOpen] = useState(false);
  //   const [isBadgeModalOpen, setIsBadgeModalOpen] = useState(false);
  const targetDate = new Date("2024-03-10T00:00:00Z"); // Change this to your target date

  const openVoteModal = () => {
    setIsVoteModalOpen(true);
  };

  const closeVoteModal = () => {
    setIsVoteModalOpen(false);
  };

  //   const openBadgeModal = () => {
  //     setIsBadgeModalOpen(true);
  //   };

  //   const closeBadgeModal = () => {
  //     setIsBadgeModalOpen(false);
  //   };

  return (
    <div className="flex items-center flex-col flex-grow pt-10">
      <div className="px-5">
        <div className="flex flex-col bg-base-100 px-10 py-10 text-center items-center max-w-xs rounded-3xl">
          <h1>Resolution</h1>
          <p>
            The state government of Colorado will install 40,000 new recycle and compost bins within the next year.
            (Cost, funding source, etc)
            {/* dd.hh.mm.ss */}
            <h5> Voting closes in - {<Countdown targetDate={targetDate} />}</h5>
          </p>
          <div className="flex flex-col bg-base-100 px-10 py-10 text-center items-center max-w-xs rounded-3xl">
            <div className="text-gray-700 flex flex-col gap-4">
              <button className="btn btn-secondary btn-sm px-2 rounded-full" onClick={openVoteModal}>
                VOTE YES
              </button>
              <VoteModal isOpen={isVoteModalOpen} onClose={closeVoteModal} />
              <button
                className="btn btn-secondary btn-sm px-2 rounded-full"
                onClick={() => console.log("button 2 clicked")}
              >
                VOTE NO
              </button>
            </div>
            {/* <div className="flex justify-center items-center h-screen">
              <div className="relative w-64 h-72">
                <Image src="../images/ProsAndCons.svg" alt="ProsAndCons" layout="fill" />
              </div>
            </div> */}
            <div className="flex justify-center items-center h-screen">
              {/* Replace 'example.svg' with your actual image file name */}
              <div className="w-full max-w-md relative" style={{ height: "37vh" }}>
                <div className="flex items-center h-full">
                  <div style={{ position: "relative", width: "100%" }}>
                    <Image src="/images/ProsAndCons.svg" alt="Example" layout="responsive" width={100} height={100} />
                  </div>
                </div>
              </div>
            </div>
            {/* <div className="px-5">
              <div className="flex flex-col bg-base-100 px-10 py-10 text-center items-center max-w-xs rounded-3xl">
                <h1>Discourse</h1>
              </div>
              <div className="container mx-auto my-8">
                <div className="flex justify-center mt-4">
                  <div className="w-1/2 p-4 border-r border-gray-300">
                    <h3 className="text-lg font-bold mb-2">Pros</h3>
                    <ul className="list-disc list-inside">
                      <li>Pro 1</li>
                      <li>Pro 2</li>
                      <li>Pro 3</li>
                    </ul>
                  </div>
                  <div className="w-1/2 p-4">
                    <h3 className="text-lg font-bold mb-2">Cons</h3>
                    <ul className="list-disc list-inside">
                      <li>Con 1</li>
                      <li>Con 2</li>
                      <li>Con 3</li>
                    </ul>
                  </div>
                </div>
              </div>
            </div>*/}
          </div>
        </div>
      </div>
    </div>
  );
};

export default Page2;
