"use client";

import NavigationButton from "~~/components/NavigationButton";
import Votes from "~~/components/VotingDisplay"

const Page1 = () => {
  return (
    <div className="flex items-center flex-col flex-grow pt-10">
      <div className="px-5">
        <div className="flex flex-col bg-base-100 px-10 py-10 text-center items-center max-w-xs rounded-3xl">
          <p>Colorado State Resolutions</p>
          <div className="flex flex-col bg-base-100 px-10 py-10 text-center items-center max-w-xs rounded-3xl">
            <div className="text-gray-700 flex flex-col gap-4">
              <button
                className="btn btn-secondary btn-sm px-2 rounded-full"
                onClick={() => console.log("button 2 clicked")}
              >
                Planting new trees
              </button>
              <NavigationButton destination="/page2" label="Installing recycle and compost bins" />
              <button
                className="btn btn-secondary btn-sm px-2 rounded-full"
                onClick={() => console.log("bottom button 4 clicked")}
              >
                Increasing property taxes for schools
              </button>
              <Votes/>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Page1;
