import logging
from rich.logging import RichHandler
from pathlib import Path
from datetime import datetime
import json

def make_rich_logger(name: str, clevel=logging.INFO, flevel=logging.DEBUG, mode='w', logdir='.') -> logging.Logger:
    """
    Sets up a logger with a RichHandler for console output and a FileHandler
    for writing logs to a file. Also silences noisy third-party loggers.

    Args:
        name (str): The name for the logger (e.g., 'daq_data').
        level (int): The logging level (e.g., logging.INFO).

    Returns:
        logging.Logger: A configured logger instance.
    """
    # The 'watchfiles' logger can be verbose, so we set its level higher.
    logging.getLogger("watchfiles").setLevel(logging.WARNING)

    # define log directory and file path
    log_dir = Path(f"{logdir}/logs")
    log_dir.mkdir(parents=True, exist_ok=True)
    log_file_path = log_dir / f"{name}_{datetime.now().strftime('%Y-%m-%d')}.log"

    # Get the logger and set its level.
    # We use getLogger(name) to get our specific application logger.
    logger = logging.getLogger(name)
    logger.setLevel(flevel)

    # Prevent messages from being passed to the root logger
    logger.propagate = False

    # Configure and add the RichHandler for console output
    # This handler is for pretty-printing logs to the terminal.
    console_handler = RichHandler(
        level=clevel,
        show_time=True,
        show_level=True,
        show_path=False, # Set to False for cleaner output
        rich_tracebacks=True,
        tracebacks_theme="monokai",
    )
    console_handler.setFormatter(logging.Formatter("[%(funcName)s()] %(message)s", datefmt="%H:%M:%S"))

    # Configure and add the FileHandler for file output
    # This handler writes logs to the file defined above.
    file_handler = logging.FileHandler(log_file_path, mode=mode)
    file_handler.setLevel(flevel)
    file_formatter = logging.Formatter(
        "%(asctime)s - %(name)s - %(levelname)s - [%(funcName)s] - %(message)s"
    )
    file_handler.setFormatter(file_formatter)

    # Add handlers to the logger, but only if they haven't been added already
    if not logger.handlers:
        logger.addHandler(console_handler)
        logger.addHandler(file_handler)

    return logger

def flat_config(template, target):
    with open(template, 'r', encoding='utf-8') as f:
            template_config = json.load(f)
    target_config = {}
    target_config['parameters'] = {}
    for i in range(len(template_config['parameters']['keys'])):
        k = template_config['parameters']['keys'][i]
        v = template_config['parameters']['values'][i]
        target_config['parameters'][k] = v
    with open(target, "w", encoding="utf-8") as f:
        json.dump(
            target_config,
            f,
            indent=4,          
            ensure_ascii=False
        )

def gen_bconfig(template, target):
    p = Path(target)
    # create the dir in case it doesn't exist
    p.parent.mkdir(parents=True, exist_ok=True)
    if not p.is_file():
        flat_config(template, target)