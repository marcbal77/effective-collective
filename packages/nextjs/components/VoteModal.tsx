import React from "react";

interface ModalProps {
  isOpen: boolean;
  onClose: () => void;
}

const VoteModal: React.FC<ModalProps> = ({ isOpen, onClose }) => {
  if (!isOpen) return null;

  const handleActionClick = () => {
    // Perform action here
    // For example: you might want to perform some action when a button in the modal is clicked
    // After performing the action, close the modal
    onClose();
  };

  return (
    <div className="fixed top-0 left-0 w-full h-full flex justify-center items-center bg-black bg-opacity-50">
      <div className="bg-white p-6 rounded-lg">
        <div className="flex justify-between items-center mb-4">
          <button className="text-gray-500 hover:text-gray-700" onClick={handleActionClick}>
            <svg className="w-6 h-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
            </svg>
          </button>
        </div>
        <div className="text-gray-700 flex flex-col gap-4">
          {/* Get walletBalance*/}
          <p>Would you like to boost this vote with your balance of _ credits?</p>
          <button
            className="btn btn-secondary btn-sm px-2 rounded-full"
            onClick={() => console.log("button 2 clicked")}
          >
            Yes - please use * of my boost credits
          </button>
          <button
            className="btn btn-secondary btn-sm px-2 rounded-full"
            onClick={() => console.log("button 3 clicked")}
          >
            No thank you
          </button>
        </div>
      </div>
    </div>
  );
};

export default VoteModal;
